class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.95.1.tar.gz"
  sha256 "6e4840cd36bfa955a975319cc2bce59b6389c37d25253a7d7186124e29716b88"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 31
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "00baa712affb42d5123f23d472b79af9fae82a68a2db3752ff64f4ceb3a00cf2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ef872ad507eccc927fedbebfc6e79baff97dc78fb97b77bb7d0e08a26c2816b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18708c9562a4809406cc8abd7e05d351b10565fe7df5dd024473e4051bb3b770"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
