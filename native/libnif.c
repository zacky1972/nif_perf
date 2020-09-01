#include <erl_nif.h>

static ERL_NIF_TERM ok_atom;

static int
load(ErlNifEnv *env, void **priv, ERL_NIF_TERM info)
{
	ok_atom = enif_make_atom(env, "ok");
	return 0;
}

static void
unload(ErlNifEnv *env, void *priv)
{

}

static int
reload(ErlNifEnv *env, void **priv, ERL_NIF_TERM info)
{
	return 0;
}

static int
upgrade(ErlNifEnv *env, void **priv, void **old_priv, ERL_NIF_TERM info)
{
	return load(env, priv, info);
}

static
ERL_NIF_TERM test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
	return ok_atom;
}

static
ErlNifFunc nif_funcs[] =
{
	// {erl_function_name, erl_function_arity, c_function}
	{"test", 0, test}
};

ERL_NIF_INIT(Elixir.NifPerf, nif_funcs, &load, &reload, &upgrade, &unload)
