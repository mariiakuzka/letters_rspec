require "spec_helper"

# Book — книга в библиотечном каталоге.
#
# `#epub?` возвращает true или false в зависимости от расширения книги (.epub или что-то другое).
# `#download_url` возвращает ссылку на скачивание книги. Книги сгруппированы по первой букве
# в названии книги:
#
# * /system/a/anatomy.pdf
# * /system/a/ants.epub
# * /system/x/xfiles.epub
class Book
  attr_reader :path

  def initialize(path:)
    @path = path
  end

  def epub?
    path.end_with?(".epub")
  end

  def download_url
    "/system/#{path_prefix}/#{filename}"
  end

  private

  def filename
    File.basename(path)
  end

  def path_prefix
    filename[0].downcase
  end
end

RSpec.describe Book do
  describe "#call" do
    let(:book) { described_class.new(path: path) }
    context 'when book format is epub' do
      #let(:book) { described_class.new(path: path) }
      let(:path) { '/system/a/ants.epub' }

      it 'checks epub format' do
        expect(book.epub?).to eq(true)
      end

      it 'returns download link' do
        expect(book.download_url).to match('/system/a/ants')
      end
    end

    context 'when book format is pdf' do
      let(:path) { '/system/a/anatomy.pdf' }

      it 'checks epub format' do
        expect(book.epub?).to eq(false)
      end

      it 'returns download link' do
        expect(book.download_url).to match('/system/a/anatomy')
      end
    end
  end
end