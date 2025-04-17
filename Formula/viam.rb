class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.71.2.tar.gz"
  sha256 "077330c93a0dba86843bfbf62a99eb3ad58ed140c4d345c1788f3af1f4da6a59"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 33
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ec5a7494a1a5147ad951a07679ebc0b67c19b69033ebcd7e9554112941628a30"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "31b64d93a54fe10880dd0706cac091b27eff50a62a26e109dbef8174e371d218"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f612a210f2017b091b7a09181bc96248ec2f43feb87fa0c6dc5c1919ba29fad3"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
