class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "48692dcea8bdb853c494b6017304906547e9387172c78fb4a55336b8be6b6e5d"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
