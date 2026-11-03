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
    rebuild 38
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "25085bf05263d26530501c162521487bd0b455061b3d13fa24e7bcf40557bd0b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8e990b229314f1cad79bcd66cd566fd80466d923709f27e93ad2b3c2a56c94a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a42b7fc507a8b5b624bf704db42b6dbc6a551a4736aedc6daab551d83fc231d2"
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
