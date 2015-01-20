module TextsHelper
  def short_source_link(text)
    short_link = text.source.sub(/\b\/.+/, '')
    link_to short_link, text.source
  end
end
