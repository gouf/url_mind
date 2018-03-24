# Manipulate records of Readlater
class ReadLatersController < ApplicationController
  # Show Readlater records
  def index
    @read_laters = ReadLater.all
  end

  # Create Readlater record
  def push
    @read_later = ReadLater.create!(read_laters_params)
  end

  # Take first record of Readlater
  def pop
    @read_later = ReadLater.pop!

    render json: @read_later
  end

  # Save multiple records of Readlater
  def bulk_push
    ReadLater.bulk_push(read_laters_params[:url])

    redirect_to read_laters_path
  end

  private

  # Retreive params from form
  def read_laters_params
    params.require(:read_laters).permit(:url)
  end
end
