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
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d43fe576ed8b58feb06d8f9d155aefc7e543ee638e8aa1c3d65f9e34caeb088a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c80b872229f53ad118b8023e22fc29188706bc1eb08823d13c4d5ae078aabab1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7967ba11cf33a60d370cd92b57e73fddccb607dce580d29a6c9b945c60d13b3"
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
