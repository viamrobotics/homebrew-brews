class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.13.0.tar.gz"
  sha256 "b9ed4d8a5343106d30c708436d841833a657857d6b8e594f54b49f88c43fd1c3"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 34
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "be2736ab9b90122ba1450f6848beeefcb0006772de4dd2190e7afc4cff517dc7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1da777492e39c81855028e4dcba50a9e4421f6e629b94e96718e714207aeb6e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fe775c6a3d293b2d889f6f500e4a74d043fcb2c9b34fb7d7f939ede7a3c2caa"
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
