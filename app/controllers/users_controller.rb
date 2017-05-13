class UsersController < ApplicationController
  before_filter :require_admin

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
    users = User.where(admin: false)
    users.each do |user|
      user.participants.destroy_all
    end
    users.destroy_all
    flash[:notice] = 'You have successfully deleted all guardians.'
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:file)
  end
end
