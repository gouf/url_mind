class ReadLatersController < ApplicationController
  def index
    @read_laters = ReadLater.all
  end

  def push
    @read_later = ReadLater.create!(read_laters_params)
  end

  def pop
    @read_later = ReadLater.pop!

    render json: @read_later
  end

  def bulk_push
    urls = extract_urls_from_markdown

    ReadLater.transaction do
      urls.each do |url|
        ReadLater.create!(url: url)
      end
    end

    redirect_to read_laters_path
  end

  private

  def read_laters_params
    params.require(:read_laters).permit(:url)
  end

  def extract_urls_from_markdown
    html = Markdown.new(read_laters_params[:url]).to_html
    links = Nokogiri::HTML(html)
    links.css('a').map { |element| element.attribute('href').value }
  end
end
