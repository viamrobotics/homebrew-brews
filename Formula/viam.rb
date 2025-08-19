class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.89.1.tar.gz"
  sha256 "427d2eedd6fd0b96711f452a6b181ba5fdaede76f2f35acf162b3402e84e9ef9"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 23
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "05d8a5aadb2d862eb686cc58ecef8b6a9fe450415a3585e6396772880d9dd746"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "440e7914f8879a37cc8fcdbd7d04e0a32571d400a8cf9af01d920dc90390a8c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63e6ccfb301af5ab508c680bb0799ec938293f3155cf432906ed28d2adc12e12"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
