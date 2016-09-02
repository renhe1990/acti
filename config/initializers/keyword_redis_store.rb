module Keyword
  def self.redis
    @redis ||= Redis.new
  end
  def self.initRedisData
    @admin_replies = Admin::Reply.all
    begin
      if @admin_replies.length < 1
        return JSON.parse '{"success":"false"}' 
      end
    Keyword.redis.flushdb
      for t in @admin_replies
        if t.category == 'event'
            Keyword.redis.set('sys_event',t.data)
        elsif t.category == 'nomatch'
            Keyword.redis.set('sys_nomatch',t.data)
        elsif (t.category == 'text' or t.category == 'graphic_text')
            @jsonObject = JSON::parse(t.data)
            if @jsonObject.length > 0 
                for i in @jsonObject
                  @keywordString = i['keyword']
                  @keywordString = @keywordString.gsub(',','|')
                  @keywordArr = @keywordString.split('|')
                  for w in @keywordArr
                    Keyword.redis.set(w,i.to_json)
                  end
                end
            end
        else
        end
      end
      return JSON.parse '{"success":"true"}' 
    rescue Exception => e
      return JSON.parse '{"success":"false"}' 
    end
  end
  initRedisData
end