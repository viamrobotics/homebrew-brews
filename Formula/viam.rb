class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.71.2.tar.gz"
  sha256 "077330c93a0dba86843bfbf62a99eb3ad58ed140c4d345c1788f3af1f4da6a59"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 34
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a8bbd970537b202aff1ac1510fff7d3adf817c75be8e6b50d631cc1f87d8515"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "819eae013686e52a6e0f5bff099242a465f75a19f8ae52de853925d791c60343"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5955295c7afbd13cdf79b8d517c6448d703321398d4c1a53d8a14f9cbc8bef2"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
