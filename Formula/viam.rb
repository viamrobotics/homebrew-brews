class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.128.1.tar.gz"
  sha256 "c73d4f6ed0b3f1c1d6a27c8873496e21fdb60df0edef3afc6101e50b3a342547"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 10
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4075f8d2f143ddd74438dbdeab9c827cc2a14f34ca32dfb278850dad8dc1aa13"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "499f584157a06b677fafe91e07bf9ea40db228b4c13e97e38496656120e7e7e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4993bc36ecde82f2fb0eb87a34494193653b1a74eeccafa2b7b014688070bf7"
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
