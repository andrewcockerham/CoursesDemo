class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index]

  ### my custom actions
  def my_courses
    @my_courses = Course.find_all_by_complete(:true)
  end

  def send_pdf
    require "net/http"
    # params[:end_date = ] = asdfa
    puts params
    # uri = URI('http://agile-everglades-3155.herokuapp.com/users/receive_certificate')
    uri = URI('http://www.skillchest.com/users/receive_certificate')
    x = Net::HTTP.post_form(uri, params)
    puts x.body
    redirect_to my_courses_path, notice: 'You have sent your pdf to SkillChest'
  end
  ### end custom actions

  def register
    @course = Course.find(params[:id])
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    # send_pdf
    puts "hi im in hte show"
    puts params
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :teacher, :end_date, :teacher_email, :complete, :pdf)
    end
end
