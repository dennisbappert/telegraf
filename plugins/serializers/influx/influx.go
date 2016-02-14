package influx

import (
	"github.com/dennisbappert/telegraf"
)

type InfluxSerializer struct {
}

func (s *InfluxSerializer) Serialize(metric telegraf.Metric) ([]string, error) {
	return []string{metric.String()}, nil
}
