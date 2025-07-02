class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.82.1.tar.gz"
  sha256 "2bd63c37d5ddaf42c5d378924f3b6e7d9da040039eabbde75a5595bad7ec162f"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 11
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c25ab71d3b9aa395ae03a21f9baf72a14337abed71593a04c72db1f6538d8beb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "027b313c3de71be5de7ecfee506c0b75487990f183ec7c42696c3f480abcc32a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8cff2b685f62aa53a76b64c61e0b4ac41ebe10fb7b43f6999d8feb7f70b3ca54"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
