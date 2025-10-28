class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.99.0.tar.gz"
  sha256 "79b072259520e428cbe53eccdfeec9aafd8e5509614fcef3a51c22abc0ca2a40"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 36
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b7f934e0898fe1c96da44d36a9508dd9b6fc8f256bbd4dea8938f70133289ce8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "76f85599f0b9f5203052f8da9306ab1d397a2573b223c1d341cfdd9a78b24dd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afb16ab57774f798aa0a009d7a36d3149ef29586fd8028757534fba7e2947e81"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
