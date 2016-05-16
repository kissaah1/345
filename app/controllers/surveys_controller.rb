class SurveysController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

  def create
    @survey = current_user.surveys.build(survey_params)
    if @survey.save
      flash[:success] = "Survey updated!"
      redirect_to current_user
    else
    	@feed_items = []
      render 'users/show'
    end
  end

  def destroy
    @survey.destroy
    flash[:success] = "Answer deleted"
    redirect_to request.referrer || users_path(@user)
  end


  private

    def survey_params
      params.require(:survey).permit(:question_1, :question_2, :question_3, :question_4,
      	:question_5, :question_6, :question_7, :question_8, :question_9, :question_10)
    end
     def correct_user
      @survey = current_user.surveys.find_by(id: params[:id])
      redirect_to current_user if @survey.nil?
    end
end
