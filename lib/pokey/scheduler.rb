require "rufus-scheduler"

class Pokey::Scheduler
  def rufus
    @rufus ||= Rufus::Scheduler.new
  end

  def self.commit!
    scheduler = new

    Pokey::Hooks.add_from_dir(Pokey.hook_dir)

    Pokey::Hooks.all.each do |hook|
      scheduler.rufus.every "#{hook.interval}s" do
        hook.make_http_request!
      end
    end
  end
end
