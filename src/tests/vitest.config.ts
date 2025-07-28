import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    coverage: {
      provider: 'c8',
      reporter: ['text', 'clover', 'json', 'html'],
      reportsDirectory: './coverage',
      include: ['src/**/*.{js,ts}'],
      exclude: [
        'src/tests/**',
        'src/**/*.test.{js,ts}',
        'src/**/*.spec.{js,ts}',
        'cdk/**',
        'node_modules/**'
      ]
    }
  },
});
