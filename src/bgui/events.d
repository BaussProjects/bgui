module bgui.events;

/**
*	Event action with no parameters.
*/
class Action {
private:
	/**
	*	The function pointer.
	*/
	void function() m_f;
	/**
	*	The delegate.
	*/
	void delegate() m_d;
public:
	/**
	*	Creates a new instance of Action.
	*	Params:
	*		f =	The function pointer.
	*/
	this(void function() f) {
		m_f = f;
	}
	
	/**
	*	Creates a new instance of Action.
	*	Params:
	*		d =	The delegate.
	*/
	this (void delegate() d) {
		m_d = d;
	}

	/**
	*	Executes the action.
	*/
	void exec() {
		if (m_f)
			m_f();
		else
			m_d();
	}
}

/**
*	Event action with a single parameter.
*/
class EventAction(T) {
private:
	/**
	*	The function pointer.
	*/
	void function(T) m_f;
	
	/**
	*	The delegate.
	*/
	void delegate(T) m_d;
public:
	/**
	*	Creates a new instance of EventAction.
	*	Params:
	*		f =	The function pointer.
	*/
	this(void function(T) f) {
		m_f = f;
	}
	
	/**
	*	Creates a new instance of EventAction.
	*	Params:
	*		d =	The delegate.
	*/
	this (void delegate(T) d) {
		m_d = d;
	}

	/**
	*	Executes the action.
	*	Params:
	*		arg =	The function argument.
	*/
	void exec(T arg) {
		if (m_f)
			m_f(arg);
		else
			m_d(arg);
	}
}