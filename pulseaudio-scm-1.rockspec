package = "pulseaudio"
version = "scm-1"
source = {
	url = "git://https://gitlab.com/doronbehar/lua-pulseaudio_cli",
}
description = {
	summary = "Bindings to libpulse",
	homepage = "https://github.com/liaonau/lua-pulseaudio",
	license = "Apache v2.0"
}
supported_platforms = {
	"linux"
}
dependencies = {
	"lua >= 5.3",
}
external_dependencies = {

}
build = {
	type = "make",
	build_variables = {
		CFLAGS="$(CFLAGS)",
		LIBFLAG="$(LIBFLAG)",
		LUA_LIBDIR="$(LUA_LIBDIR)",
		LUA_BINDIR="$(LUA_BINDIR)",
		LUA_INCDIR="$(LUA_INCDIR)",
		LUA="$(LUA)",
	},
	install_variables = {
		INST_PREFIX="$(PREFIX)",
		INST_BINDIR="$(BINDIR)",
		INST_LIBDIR="$(LIBDIR)",
		INST_LUADIR="$(LUADIR)",
		INST_CONFDIR="$(CONFDIR)",
	},
}
