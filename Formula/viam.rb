class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "36db9e2b46c5d1cdb96e3bfeebe567dbebc8afd312c24d8a6fcfac0d734d7a57"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 19
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1354996e6c0dc977a844a7cdbbfe3d3cea8a88396696d58db85a862e912f65d5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3be2c8a854cdef4d7ddf3e83d285c9dfb9d00ee23c89afc4bc305b1f01c3e8a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79cceb58ff1efa3f5769719c1c856419b7890c8219c8da9b9b7f6bf90123626a"
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
