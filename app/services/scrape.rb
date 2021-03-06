# Runs through purl. TODO: convert it into a service object
class ScrapeService
  def self.search(search, url = "https://consultaremedios.com.br")
    @url = url || "https://consultaremedios.com.br"
    p search_by_name(search)
  end

  private

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.search_by_name(product_name)
    product_name = product_name.downcase.gsub(' ', '+')
    doc = get_page(@url + "/busca?termo=" + product_name)

    doc.search('.product-block__title a').map do |e|
      get_info(e.attr('href'))
    end
  end

  def self.get_info(product_url)
    doc = get_page(@url + product_url)
    info = {}
    doc.search('.product-header__title').each { |e| info[:name] = e.text }
    doc.search('hr').each { |e| info[:composition] = e.next_element.next_element.text.split(', ') }
    info
  end
end
