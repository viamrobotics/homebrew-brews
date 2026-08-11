class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "586d3b89ad03a2daf32f056fe3ba0550146adc7bd1ed2a1fcef2b13e7424507d"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 21
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d216af0bcf361d7fdab636d994971c0bcbe2c9772b64269bf6f460f4846b4f03"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5243a6c4d599c094735569e789618351a6ed77d90fd737afdc8738b940316358"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28ec23aee71d137e0020e9424e9696e774f665ba64b3bd1bbb1534035140e7eb"
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
