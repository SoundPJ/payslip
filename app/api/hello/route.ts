/**
 * @swagger
 * /api/hello:
 *   get:
 *     description: Returns a greeting
 *     responses:
 *       200:
 *         description: Success
 */
export async function GET() {
  return Response.json({ message: 'Hello World' });
}