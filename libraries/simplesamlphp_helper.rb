module Simplesamlphp
  module Helper
    def simplesamlphp_installed?(path)
      File.exist?("#{path}/LICENSE")
    end

    def simplesamlphp_updated?(path, version)
      return false unless simplesamlphp_installed?(path)
      File.open("#{path}/docs/simplesamlphp-changelog.txt").grep(/#{version}/).any?
    end
  end
end
