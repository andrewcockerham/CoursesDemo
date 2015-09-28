class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
    @course = Course.find(params[:id])
    @student_email = params[:student_email]
    @student = Student.find_by_email(@student_email)
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    # @course_id = pa
    @attendance = Attendance.new(attendance_params)

    @student_email = params[:student_email]
    if Student.find_by_email(@student_email) # student exists
      @student_id = Student.find_by_email(@student_email).id
      @attendance.student_id = @student_id
    else # create new student with that email
      @new_student = Student.new(email: @student_email)
      @new_student.save
      @attendance.student_id = @new_student.id
    end
    # @attendance.student_id = @student.id
    # @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        @notice_string = 'Congratulations! You registered for ' + Course.find(@attendance.course_id).title
        if params[:send_to_skillchest]
          ## post to skillchest new-attendance url
          # @notice_string += 'send'

          require "net/http"
          # params = {'box1' => '',
          # 'button1' => 'Submit'
          # }
          # x = Net::HTTP.post_form(URI.parse('localhost:3000/users/new_registration'), params)
          uri = URI('http://www.skillchest.com/users/new_registration')
          puts uri
          x = Net::HTTP.post_form(uri, params)
          puts x.body
        end
        format.html { redirect_to @attendance, notice: @notice_string }
        format.json { render action: 'show', status: :created, location: @attendance }
      else
        format.html { render action: 'new' }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:student_id, :course_id)
    end
end
