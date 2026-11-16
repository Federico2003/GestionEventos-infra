export default {
  async fetch() {
    return Response.json({
      status: "provisioned",
      message: "Worker creado con Terraform; el pipeline desplegará la API de Planora."
    });
  }
};
