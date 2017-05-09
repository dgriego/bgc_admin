class UsersController < ApplicationController
  before_action Participant.disassociate_guardians, only: :destroy_all_guardians

  before_filter do
    unless current_user && current_user.admin?
      redirect_to root_path,
                  {flash: {error: 'You do not have permission to do that.'}}
    end
  end

  def index # GET '/users'
    @guardians = User.where(admin: false)
  end

  def import # POST '/users/import'
    begin
      users = User.import(user_params[:file])
      redirect_to users_path, notice: 'Import was successful.'
    rescue Exception => e
      redirect_to users_path, {flash: {error: e}}
    end
  end

  def destroy_all_guardians # DELETE '/users'
    User.where(admin: false).delete_all
    flash[:notice] = 'You have successfully deleted all guardians.'
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:file)
  end
end
