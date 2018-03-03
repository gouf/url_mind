class ReadLatersController < ApplicationController
  def index
    @read_laters = ReadLater.all
  end
end
