require 'formula'

class VrJugglua < Formula
  homepage 'https://github.com/vancegroup/vr-jugglua'
  head 'https://github.com/casallas/vr-jugglua.git', :commit => 'a4c224668bbf611410e0faa5e5ca6d989e148a8a'
  url 'https://github.com/casallas/vr-jugglua.git', :branch => 'patch-1'
  version '2.0.0'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'open-scene-graph28'
  depends_on 'vr-juggler'
  depends_on 'qt'

  #TODO really vr-jugglua should depend on the local libraries rather than the bundled ones
  keg_only "VR Jugglua Installs its own lua, and luabind, which conflict with homebrew's"

  def install
    # Our version of vr juggler isn't recognized by CMake
    inreplace 'CMakeLists.txt', '3.0 EXACT REQUIRED', ''

    args = std_cmake_args
    # Don't bundle dependent libraries, they should be in our system anyways
    args << "-DINSTALL_LIBRARIES_BUNDLE=OFF"
    mkdir 'build' do
      system "cmake", "..", *args
      system "make install"
    end
  end
end
