class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.125.0.tar.gz"
  sha256 "7092ccccaf1fb4b6647af1404100da2edcfca910d6d3bb8389f690160329e131"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c7064bf793ee71fdf51840dca66b79d25f8c565332dcc4d966b9c703f2f3cd45"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eecd3f8b9421eea62fea7f93df49e4aa5f5f811f0e4fe2661142746d77cbda2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ba6bb9522de01a8377fac0698a2230e0e9faa6e1c93165a5bea16ee30cab5f6"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
