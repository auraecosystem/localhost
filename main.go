package main

import (
	"fmt"
	"time"

	"github.com/expr-lang/expr"
)

type Post struct {
	Body string    `expr:"body"`
	Date time.Time `expr:"date"`
}

type Environment struct {
	Posts []Post `expr:"posts"`
}

func (Environment) Format(t time.Time) string {
	return t.Format(time.RFC3339)
}

type Engine struct {
	program expr.Program
}

func NewEngine(source string) (*Engine, error) {
	program, err := expr.Compile(
		source,
		expr.Env(Environment{}),
	)
	if err != nil {
		return nil, fmt.Errorf("compile expression: %w", err)
	}

	return &Engine{
		program: program,
	}, nil
}

func (e *Engine) Run(env Environment) (any, error) {
	result, err := expr.Run(e.program, env)
	if err != nil {
		return nil, fmt.Errorf("run expression: %w", err)
	}

	return result, nil
}

func main() {
	engine, err := NewEngine(`
		map(
			posts,
			Format(.date) + ": " + .body
		)
	`)
	if err != nil {
		panic(err)
	}

	now := time.Now()

	result, err := engine.Run(Environment{
		Posts: []Post{
			{Body: "Oh My God!", Date: now},
			{Body: "How you doin?", Date: now},
			{Body: "Could I be wearing any more clothes?", Date: now},
		},
	})
	if err != nil {
		panic(err)
	}

	fmt.Println(result)
}
