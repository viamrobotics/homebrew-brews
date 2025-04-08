class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.70.0.tar.gz"
  sha256 "47f744835d51eeae10ca2c6cf3fbe1d8d7297590713204da1cfc3b224b2e5c0d"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 30
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1bada120fe256abf410177f39baba9203b7576554d52e9ed5b33b179b8815245"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "03e33e3613bc0e39720aca81872a99ae92a024d3fc4f67851670bac9c2c79509"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7744aab3b69e2120c271e314e0774ddf019a853c99659d76089dabc89c8e83c5"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
