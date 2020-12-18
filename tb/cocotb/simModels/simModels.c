#include <Python.h>


// Declare function prototypes
static PyObject* simModels_add(PyObject* self, PyObject* args);
static PyObject* simModels_addu(PyObject* self, PyObject* args);
static PyObject* simModels_sub(PyObject* self, PyObject* args);
static PyObject* simModels_subu(PyObject* self, PyObject* args);
static PyObject* simModels_sll(PyObject* self, PyObject* args);
static PyObject* simModels_slt(PyObject* self, PyObject* args);
static PyObject* simModels_sltu(PyObject* self, PyObject* args);
static PyObject* simModels_xor(PyObject* self, PyObject* args);
static PyObject* simModels_srl(PyObject* self, PyObject* args);
static PyObject* simModels_sra(PyObject* self, PyObject* args);
static PyObject* simModels_or(PyObject* self, PyObject* args);
static PyObject* simModels_and(PyObject* self, PyObject* args);

static PyMethodDef simModels_methods[] = 
{
	// Python name			C-function name		argument presentation, 		description
	{"add",					simModels_add,	    METH_VARARGS,				"Returns the addition of two signed integer 32bits in size (two's complement) (a+b)."},
	{"addu",				simModels_addu,	    METH_VARARGS,				"Returns the addition of two unsigned integer 32bits in size (two's complement) (a+b)."},
	{"sub",					simModels_sub,	    METH_VARARGS,				"Returns the substraction of two signed integer 32bits in size (two's complement) (a-b)."},
	{"subu",				simModels_subu,	    METH_VARARGS,				"Returns the substraction of two unsigned integer 32bits in size (two's complement) (a-b)."},
	{"sll",					simModels_sll,	    METH_VARARGS,				"Returns the logical left shift (a << b)."},
	{"slt",					simModels_slt,	    METH_VARARGS,				"Returns 1 if a < b, else it returns 0 (int)."},
	{"sltu",				simModels_sltu,	    METH_VARARGS,				"Returns 1 if a < b, else it return 0 (unsigned int)."},
	{"xor",					simModels_xor,	    METH_VARARGS,				"Returns a ^ b (Bitwise xor)."},
	{"srl",					simModels_srl,	    METH_VARARGS,				"Returns the logical right shift (a >> b)."},
	{"sra",					simModels_sra,	    METH_VARARGS,				"Returns the arithmetic right shift (a >> b)."},
	{"orz",					simModels_or,	    METH_VARARGS,				"Returns (a | b) (bitwise or) (z is added because or is a keyword in python)."},
	{"andz",				simModels_and,	    METH_VARARGS,				"Returns (a & b) (bitwise and) (z is added because add is a keyword in python)."},
	{NULL, NULL, 0, NULL}
};

static struct PyModuleDef simModels_module =
{
	PyModuleDef_HEAD_INIT,
    "simModels", /* name of module */
    "Arithmetic models for testing the ALU",          /* module documentation, may be NULL */
    -1,          /* size of per-interpreter state of the module, or -1 if the module keeps state in global variables. */
    simModels_methods
};

PyMODINIT_FUNC PyInit_simModels(void)
{
	return PyModule_Create(&simModels_module);
}

static PyObject* simModels_add(PyObject* self, PyObject* args)
{
	int opa_i,opb_i;
	int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "ii", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}
	
	res_o = opa_i + opb_i;
	
	return Py_BuildValue("i", res_o);
}

static PyObject* simModels_sub(PyObject* self, PyObject* args)
{
	int opa_i,opb_i;
	int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "ii", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}
	
	res_o = opa_i - opb_i;
	
	return Py_BuildValue("i", res_o);
}



static PyObject* simModels_addu(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}
	
	res_o = opa_i + opb_i;
	
	return Py_BuildValue("I", res_o);
}

static PyObject* simModels_subu(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}
	
	res_o = opa_i - opb_i;
	
	return Py_BuildValue("I", res_o);
}

static PyObject* simModels_sll(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}
	
	res_o = opa_i << (opb_i & 0x1F); // Only take the first 5 bits
	
	return Py_BuildValue("I", res_o);
}


static PyObject* simModels_slt(PyObject* self, PyObject* args)
{
	int opa_i,opb_i;
	int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "ii", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	if (opa_i < opb_i)
	{
		res_o = 1;
	}
	else
	{
		res_o = 0;
	}	
	
	return Py_BuildValue("i", res_o);
}


static PyObject* simModels_sltu(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	if (opa_i < opb_i)
	{
		res_o = 1;
	}
	else
	{
		res_o = 0;
	}	
	
	return Py_BuildValue("I", res_o);
}


static PyObject* simModels_xor(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	res_o = opa_i ^ opb_i;	
	return Py_BuildValue("I", res_o);
}


static PyObject* simModels_srl(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	res_o = opa_i >> opb_i;	
	return Py_BuildValue("I", res_o);
}


static PyObject* simModels_sra(PyObject* self, PyObject* args)
{
	int opa_i,opb_i;
	int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "ii", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	res_o = opa_i >> opb_i; // TODO: Some compilers don't treat this as an arithmetic shift. Write a custom function for this.	
	return Py_BuildValue("i", res_o);
}


static PyObject* simModels_or(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	res_o = opa_i | opb_i;	
	return Py_BuildValue("I", res_o);
}



static PyObject* simModels_and(PyObject* self, PyObject* args)
{
	unsigned int opa_i,opb_i;
	unsigned int res_o;

	// We expect 2 integer arguments to this function
	if (!PyArg_ParseTuple(args, "II", &opa_i, &opb_i))
	{
		return NULL; // Return error if none found
	}

	res_o = opa_i & opb_i;	
	return Py_BuildValue("I", res_o);
}


