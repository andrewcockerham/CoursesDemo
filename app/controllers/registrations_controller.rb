class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
    @course = Course.find(params[:id])
    @student_email = params[:student_email]
    @student = Student.find_by_email(@student_email)
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  # POST /registrations.json
  def create
    # @course_id = pa
    @registration = Registration.new(registration_params)

    @student_email = params[:student_email]
    if Student.find_by_email(@student_email) ## student exists
      @student_id = Student.find_by_email(@student_email).id
      @registration.student_id = @student_id
    else # create new student with that email
      @new_student = Student.new(email: @student_email)
      @new_student.save
      @registration.student_id = @new_student.id
    end
    # @registration.student_id = @student.id
    # @registration = Registration.new(registration_params)

    respond_to do |format|
      if @registration.save
        @notice_string = 'Congratulations! You registered for ' + Course.find(@registration.course_id).title 
        if params[:send_to_skillchest]
          ## post to skillchest new-registration url
          @notice_string += 'send'

          require "net/http"
          # params = {'box1' => 'Nothing is less important than which fork you use. Etiquette is the science of living. It embraces everything. It is ethics. It is honor. -Emily Post',
          # 'button1' => 'Submit'
          # }
          # x = Net::HTTP.post_form(URI.parse('localhost:3000/users/new_registration'), params)
          uri = URI('http://vast-inlet-7833.herokuapp.com/users/new_registration')
          x = Net::HTTP.post_form(uri, params)
          puts x.body
        end
        format.html { redirect_to @registration, notice: @notice_string }
        format.json { render action: 'show', status: :created, location: @registration }
      else
        format.html { render action: 'new' }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:student_id, :course_id)
    end
end
