class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.61.0.tar.gz"
  sha256 "175dd8d4ff326757bc58bd87b117b3f7ddcaef0b222bf7853fb859dcac6ad897"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 18
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3aae13ef3b4f577e189a2ec586f4d52f7a57a2e9d8cd061810936187e5f81550"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d488fbc3076bd3266bda0f983ccf3a78ab02331118deb9a3a6bb6af353224aa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "39444ec3e5677f5e8f7db1a7cca484e4996b045f543b2129eb3aa03ccea5f989"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
