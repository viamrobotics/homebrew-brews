class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.15.0.tar.gz"
  sha256 "210ac4daee4db4b1f22d40eba28203c967e4a8d4911bc2da74d7dea1f4ce77f2"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 39
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "31fff9b24caa51130b24cbdb203b989f833cf62e0b7f1f1b361e5fe5f3c6655c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1f15f732f72def19dc91cba2bc620b6aefb018c471922a942c51a949dba7a637"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19ff3d460b39d97cb81d6594d3ba47ba455af9f6602846caabcc10fd88a6cf1b"
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
