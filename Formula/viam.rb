class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.70.0.tar.gz"
  sha256 "47f744835d51eeae10ca2c6cf3fbe1d8d7297590713204da1cfc3b224b2e5c0d"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 31
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b8c64d9eb8b2a8ff9926c6bc0842af7dd1245305f7d02beca5558ba15c8b4de3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "442fa97749a4e5967a4944c2694a4674992c64f21014be38892b0d229ef77f57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9452bf2d13f316148e69d25be9873420d534800701557ccdb18f69f1cbff9898"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
