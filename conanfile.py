from conan import ConanFile
from conan.tools.files import get, copy, download
from conan.errors import ConanInvalidConfiguration
from conan.tools.cmake import cmake_layout
from conan.tools.files import copy

class CompressorRecipe(ConanFile):
    name = "IPRJC"
    version = "0.1"
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeToolchain", "CMakeDeps"
    license = "MIT"
    description = """a template stater c++ project"""
    author = "Trung D.QUOC (tamgiangbui@gmail.com)"
    tool_requires = "cppcheck/2.14.1" , "android-ndk/r26d"
    def requirements(self):
        self.requires("sfml/2.6.1")
        self.requires("glad/0.1.36")
        self.requires("raylib/5.0")
        self.requires("imgui/cci.20230105+1.89.2.docking")
        self.requires("sdl_ttf/2.22.0")
        self.requires("sdl/2.30.4")
        self.requires("box2d/2.4.1")
        self.requires("sdl_image/2.6.3")
        self.requires("sdl_mixer/2.8.0")
        self.requires("stb/cci.20240213")
        self.requires("catch2/3.6.0")
        self.requires("emsdk/3.1.50")
        self.requires("joltphysics/3.0.1")
        self.requires("assimp/5.4.1")
        self.requires("ozz-animation/0.14.1")
        self.requires("openal-soft/1.23.1")
        self.requires("mimalloc/2.1.7")
        self.requires("freetype/2.13.2")
        self.requires("eastl/3.21.12")
        self.requires("benchmark/1.8.4")
        self.requires("asio/1.30.2")
        self.requires("flatbuffers/24.3.25")
        self.requires("easy_profiler/2.1.0")
        self.requires("tracy/cci.20220130")
        self.requires("spdlog/1.14.1")



    def build_requirements(self):
        self.tool_requires("cmake/3.22.6")

    def generate(self):
        dep = self.dependencies["sfml"]
        copy(self, "*", dep.cpp_info.resdirs[0], os.path.join(self.source_folder, "libs"))

    def layout(self):
        multi = True if self.settings.get_safe("compiler") == "msvc" else False
        if multi:
            self.folders.generators = os.path.join("build", "generators")
            self.folders.build = "build"
        else:
            self.folders.generators = os.path.join("build", str(self.settings.build_type), "generators")
            self.folders.build = os.path.join("build", str(self.settings.build_type))v