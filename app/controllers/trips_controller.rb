class TripsController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      flash[:notice] = "#{trip_params[:title]} has been added."
      redirect_to trips_path
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])

    if @trip.update(trip_params)
      flash[:notice] = "#{trip_params[:title]} has been updated"
      redirect_to trips_path
    else
      render :edit
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.participants.each { |participant| participant.destroy }
    trip.destroy
    flash[:notice] = "#{trip.title} was removed."
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:title,
      :location, :seats, :alt_seats, :published,
      :start_date, :start_time, :end_time)
  end
end
