class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.14.3.tar.gz"
  sha256 "98eedae03898e3199eb0b641d944a06d4b60dc7f094e46fb10f9ab100cea3a54"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 36
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cd65a97792ae31f69825c1da87bb7f22a0955ce7e7f6c83e5b8fdb7ef75cb506"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "49737a98252411716739a7826944454b0b5d3309db8addd6f86d4cf2b937b67f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98e7db7f4a746839b02df11d5dbaba609aa5691c92f77757c4ba0b14fc6cabe1"
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
