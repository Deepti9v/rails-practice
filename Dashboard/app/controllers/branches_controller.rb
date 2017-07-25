class BranchesController < ApplicationController
  def index
    @branch = Branch.all
  end

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(branch_params)

    if @branch.save
      redirect_to :root
    else
      flash[:errors] = @branch.errors.full_messages
      redirect_to :back
    end

  end

  def edit
    @branch = Branch.find(params[:id])
  end


  def show
    @branch = Branch.find(params[:id])
  end

  def destroy
    Branch.find(params[:id]).destroy
    redirect_to :root
  end

  def update
    @branch = Branch.find(params[:id])
    if @branch.update(branch_params)
        redirect_to :root
    else
       flash[:error] = @branch.errors.full_messages
       redirect_to :back
    end
  end

  private
  def branch_params
    params.require(:branch).permit(:branch,:street,:city,:state)
  end
end
