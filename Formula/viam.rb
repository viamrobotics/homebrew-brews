class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/fleet/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.22.1.tar.gz"
  sha256 "c2e42745990b41622919605a0a5f712627f2bc39cc8d93429d147124888c86b7"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
