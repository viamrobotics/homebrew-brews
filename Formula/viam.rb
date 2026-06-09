class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.130.0.tar.gz"
  sha256 "2cc0e69f26e368620ea60c9384870d6495125bb71641d12bbba0e8d573bdcae4"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 14
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db27b679f9939d6d58cb6fd5893f6d0b1f5189eec019af1e043545341fefd729"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f1ff36bf43192d0726bce48bdc67090595c56a635426174e3866e0068049ce62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1cb72ec3ede016bdcb5f4cd55ef387c055068a0434e214fc31402acde5509cf3"
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
