class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "562ff529fa5e7c7b3f84687dc91755beb14d49c7977a3cd438147bae9c5da96a"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
