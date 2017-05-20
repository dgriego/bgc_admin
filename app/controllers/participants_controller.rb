class ParticipantsController < ApplicationController
  # before_action :require_admin, except: [:index, :show]
  # before_filter :require_admin

  def index # GET '/participants'
    @participants = Participant.all
  end

  def import # POST '/users/import'
    begin
      users = Participant.import(participant_params[:file])
      redirect_to participants_path, notice: 'Import was successful.'
    rescue Exception => e
      redirect_to participants_path, {flash: {error: e}}
    end
  end

  def destroy_all_participants # DELETE '/participants'
    participants = Participant.all
    participants.each do |participant|
      participant.users.destroy_all
    end
    participants.destroy_all
    flash[:notice] = 'You have successfully deleted all participants.'
    redirect_to participants_path
  end
  #
  # private
  #
  def participant_params
    params.require(:participant).permit(:file)
  end
end
