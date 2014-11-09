module Jekyll

  class PartyPage < Page
    def initialize(site, base, dir, party)
      @site = site
      @base = base
      @dir = dir

      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'party.html')
      self.data['party'] = party
      self.data['title'] = party['party_name']

    end
  end

  class JSONPartyPage < Page
    def initialize(site, base, dir, party)
      @site = site
      @base = base
      @dir = dir

      @name = 'data.json'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'party.json')
      self.data['party'] = party
      self.data['title'] = party['party_name']

    end
  end

  class PartyPageGenerator < Generator
    safe true
    
    def to_slug(s)
        #strip the string
        ret = s.strip

        #blow away apostrophes
        ret.gsub! /['`]/,""

        # @ --> at, and & --> and
        ret.gsub! /\s*@\s*/, " at "
        ret.gsub! /\s*&\s*/, " and "

        #replace all non alphanumeric, underscore or periods with underscore
         ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  

         #convert double underscores to single
         ret.gsub! /-+/,"-"

         #strip off leading/trailing underscore
         ret.gsub! /\A[-\.]+|[-\.]+\z/,""

         ret
      end
      
    def generate(site)
      if site.layouts.key? 'party'
        dir = 'parties/'
        site.data['parties'].each do |party|
          party_name = to_slug party['party_name']
          site.pages << PartyPage.new(site, site.source, File.join(dir, party_name), party)
          site.pages << JSONPartyPage.new(site, site.source, File.join(dir, party_name), party)
        end
      end
    end
  end

end