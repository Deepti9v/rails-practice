class StudentsController < ApplicationController

  def index
    @student = Student.all
  end

  def new
    @branch = Branch.find(params[:branch_id])

  end

  def create
    puts "hey ***********"
    @student = Student.new(student_params)
    if @student.save
      redirect_to :root
    else
      flash[:errors] = @student.errors.full_messages
      redirect_to :root
    end
  end

  def edit
    @branch = Branch.find(params[:branch_id])
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to :root
    else
      flash[:errors] = @student.errors.full_messages
      redirect_to :root
    end
  end

  def show
    @branch = Branch.find(params[:branch_id])
    @student = Student.find(params[:id])
  end

  def destroy
  end

  private
    def student_params
      params.require(:student).permit(:first_name,:last_name,:email,:branch_id)
    end
end
