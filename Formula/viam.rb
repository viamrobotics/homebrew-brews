class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.51.1.tar.gz"
  sha256 "a83ad4a7ae1e0f6a85803215dc0d2ce2b451235c1a663df6dcdaa71a83fd8f49"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ec93e70a7682c6266463e669b741e5e64606e7a7a57a06cef56c067c201404c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2044d1c774ed6af6b7ae64f477d05082e246aac7affae73ae11ae324f711f407"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75cb5ce8eb53af7fb87e82f2b72b0fbd11559f4342fab00e09cb48e64de42f13"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
