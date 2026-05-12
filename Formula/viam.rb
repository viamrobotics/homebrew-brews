class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.126.1.tar.gz"
  sha256 "011fde4cb3ff31ae847964ac7d6edc58feaeacddd3c91b3542b089ca3f259de7"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0c45bcb16be5ec0281486dae21b2317beb57eb8fb8d06d1e7b21b8e48ed098cc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ba577a6665e088e39b52e97af563b00230e38b97c19359f6eccc3a22462f71f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea5464fbccbcca29c97cbfec09824b8bc8c34569afbfd0272b71d03a72bbf1c6"
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
