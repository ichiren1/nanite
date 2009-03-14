module Nanite
  class LocalState < ::Hash
    def initialize(hsh={})
      hsh.each do |k,v|
        self[k] = v
      end
    end

    def all_services
      all(:services)
    end

    def all_tags
      all(:tags)
    end

    def nanites_for(service, *tags)
      tags = tags.dup.flatten
      res = select { |name, state| state[:services].include?(service) }
      unless tags.empty?
        res.select {|a|
          !(a[1][:tags] & tags).empty?
        }
      else
        res
      end
    end

    private

    def all(key)
      map { |n,s| s[key] }.flatten.uniq.compact
    end

  end # LocalState
end # Nanite
